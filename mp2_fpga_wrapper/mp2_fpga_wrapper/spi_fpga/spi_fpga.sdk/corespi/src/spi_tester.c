/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * spi_tester.c: Will test send/receive functions of SPI module
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */
#define SPI_DEVICE_ID        XPAR_SPI_0_DEVICE_ID
#define GPIO_DEVICE_ID         XPAR_AXI_GPIO_0_DEVICE_ID
#define LED_CHANNEL            0x1

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xspi.h"
#include "xgpio.h"

static XSpi SpiInstance;
static XGpio GpioInstance;

int init_spi(XSpi *SpiInstancePtr);
void spi_write(XSpi *SpiInstancePtr, u8 addr, u8 value);
u8 spi_read(XSpi *SpiInstancePtr, u8 addr);
int init_gpio(XGpio *GpioInstancePtr);
void delay(int n);

int main()
{
    //This is all initialization code, you don't need to modify this
    init_platform();
    init_spi(&SpiInstance);
    init_gpio(&GpioInstance);

    u8 LED_data = 0x1;
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);

    LED_data |= 0x1<<1;
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);

    // Test 1: write 0xCA to 0x55, read from 0x55
    int addr = 0x55;
    int value = 0xCA;
    spi_write(&SpiInstance, addr, value); //spi_write needs to be filled in
    u8 res = spi_read(&SpiInstance, addr); //spi_read has been provided

    if (res != value) {
        LED_data |= 0x1<<2;
        XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
        //You need to insert a breakpoint here to check the variables if your tester breaks.
        return 0;
    }

    // Test 2: write 0x06 to 0x55, read from 0x55
    addr = 0x55; value = 0x16;
    spi_write(&SpiInstance, addr, value); //spi_write needs to be filled in
    res = spi_read(&SpiInstance, addr); //spi_read has been provided

    if (res != value) {
        LED_data |= 0x1<<2;
        XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
        //You need to insert a breakpoint here to check the variables if your tester breaks.
        return 0;
    }

    // Test 3: write all ones to address of all ones
    addr = 0b11111111; value = 0b11111111;
    spi_write(&SpiInstance, addr, value); //spi_write needs to be filled in
    res = spi_read(&SpiInstance, addr); //spi_read has been provided

    if (res != value) {
        LED_data |= 0x1<<2;
        XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
        //You need to insert a breakpoint here to check the variables if your tester breaks.
        return 0;
    }

    //Everything below is cleanup code, you don't need to modify this
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
    LED_data |= 0x1<<3;
    XGpio_DiscreteWrite(&GpioInstance, LED_CHANNEL, LED_data);
    cleanup_platform();
    return 0;
}

void spi_write(XSpi *SpiInstancePtr, u8 addr, u8 value){
    // TODO: Your code here! Read the xspi.h file for more information on XSpi_Transfer()
    u8 addr_byte = (addr << 1);
    u8 SendBuf[2];
    SendBuf[0] = addr_byte;
    SendBuf[1] = value;
    XSpi_Transfer(SpiInstancePtr, SendBuf, NULL, 2);
}

u8 spi_read(XSpi *SpiInstancePtr, u8 addr){
    /*SpiInstancePtr is the pointer to the SPI protocol object we created
     * during the beginning lines of main()*/
    u8 addr_byte = (addr << 1); //Shifted, because we have 7 bits of addr, 1 bit of R/W
    addr_byte |= 0x1;
    u8 RcvBuf[2];
    u8 SendBuf[2];
    SendBuf[0] = addr_byte;
    SendBuf[1] = 0;    //2nd byte is 0, because we're reading data
    XSpi_Transfer(SpiInstancePtr, SendBuf, RcvBuf, 2); //The 2 is the # of expected bytes returned
    return RcvBuf[1]; //1st byte of RcvBuf is garbage (from when the addr was shifted in), 2nd byte is data
}

int init_gpio(XGpio *GpioInstancePtr){
    int Status;
    Status = XGpio_Initialize(GpioInstancePtr, GPIO_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XGpio_SetDataDirection(GpioInstancePtr, LED_CHANNEL, 0x0);
    return XST_SUCCESS;
}

int init_spi(XSpi *SpiInstancePtr){
    int Status;
    XSpi_Config *ConfigPtr;    /* Pointer to Configuration data */

    ConfigPtr = XSpi_LookupConfig(SPI_DEVICE_ID);
    if (ConfigPtr == NULL) {
        return XST_DEVICE_NOT_FOUND;
    }
    Status = XSpi_CfgInitialize(SpiInstancePtr, ConfigPtr,
                  ConfigPtr->BaseAddress);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    Status = XSpi_SelfTest(SpiInstancePtr);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    if (SpiInstancePtr->SpiMode != XSP_STANDARD_MODE) {
        return XST_SUCCESS;
    }
    Status = XSpi_SetOptions(SpiInstancePtr, XSP_MASTER_OPTION);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }
    XSpi_Start(SpiInstancePtr);
    XSpi_IntrGlobalDisable(SpiInstancePtr);
    return XST_SUCCESS;
}

void delay(int n){
    int i;
    volatile int k;
    for(i = 0; i < n; i++){
        k++;
    }
}




