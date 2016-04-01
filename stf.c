
#include <stdio.h>
#include <libserialport.h>

int main()
{
	printf("Enumerating serial ports\n\n");

	enum sp_return sp_ret;			

	struct sp_port **list_ptr;
	sp_ret = sp_list_ports(&list_ptr);

	struct sp_port **ptr = list_ptr;
	do 
	{
		printf("%s : %s\n", (*ptr)->name, (*ptr)->description);
	} 
	while (*(++ptr)); 
	printf("\nOver.\n");

	sp_free_port_list(list_ptr);
	return 0;
}
