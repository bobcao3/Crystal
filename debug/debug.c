/*
 * =====================================================================================
 *
 *       Filename:  debug.c
 *
 *    Description:  调试相关的函数
 *
 *        Version:  1.0
 *        Created:  2013年11月06日 15时16分18秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Hurley (LiuHuan), liuhuan1992@gmail.com
 *        Company:  Class 1107 of Computer Science and Technology
 *
 * =====================================================================================
 */

#include "debug.h"

static elf_t kernel_elf;

void init_debug()
{
	// 从 GRUB 提供的信息中获取到内核符号表和代码地址信息
	kernel_elf = elf_from_multiboot(glb_mboot_ptr);
}

void panic(const char *msg)
{
	// 致命错误发生后打印栈信息后停止在这里
	while(1);
}
