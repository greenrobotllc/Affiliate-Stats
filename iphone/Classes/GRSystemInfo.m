/*
 *  GRSystemInfo.c
 *  EVSuperNova
 *
 *  Created by Adam Markey on 4/9/09.
 *  Copyright 2009 GreenRobot LLC. All rights reserved.
 *
 */

#include "GRSystemInfo.h"
#include <sys/sysctl.h>
#include <mach/mach.h>

int memFree() {
	int mem = -1;
	vm_statistics_data_t vmStats;
	mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
	if (kernReturn == KERN_SUCCESS)
		mem = vm_page_size * vmStats.free_count;

	return mem;
}

