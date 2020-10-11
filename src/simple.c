#include <gdnative_api_struct.gen.h>

#include <string.h>
#include <stdio.h>
#include "addvector.h"

// test
//
const godot_gdnative_core_api_struct *api = NULL;
const godot_gdnative_ext_nativescript_api_struct *nativescript_api = NULL;

void *simple_constructor(godot_object *p_instance, void *p_method_data);

void simple_destructor(godot_object *p_instance, void *p_method_data, void *p_user_data);

godot_variant simple_get_data(godot_object *p_instance, void *p_method_data,
		void *p_user_data, int p_num_args, godot_variant **p_args);

 
void GDN_EXPORT godot_gdnative_init(godot_gdnative_init_options *p_options) {
	api = p_options->api_struct;
	for (int i = 0; i < api->num_extensions; i++) {
		switch (api->extensions[i]->type) {
			case GDNATIVE_EXT_NATIVESCRIPT: {
				nativescript_api = (godot_gdnative_ext_nativescript_api_struct *)api->extensions[i];
			}; break;
			default: break;
		}
	}
}

void GDN_EXPORT godot_nativescript_init(void *p_handle) {
	godot_instance_create_func create = { NULL, NULL, NULL };
	create.create_func = &simple_constructor;

	godot_instance_destroy_func destroy = { NULL, NULL, NULL };
	destroy.destroy_func = &simple_destructor;

	nativescript_api->godot_nativescript_register_class(p_handle, "Simple", "Reference",
			create, destroy);

	godot_instance_method get_data = { NULL, NULL, NULL };
	get_data.method = &simple_get_data;

	godot_method_attributes attributes = { GODOT_METHOD_RPC_MODE_DISABLED };

	nativescript_api->godot_nativescript_register_method(p_handle, "Simple", "get_data",
			attributes, get_data);
}

typedef struct user_data_struct {
	char data[256];
        int* arr;//[100*100];
	godot_array gdoarr;
	godot_variant intarr[100*100];
	godot_variant ret;
} user_data_struct;


void *simple_constructor(godot_object *p_instance, void *p_method_data) {
	user_data_struct *user_data = (user_data_struct*)api->godot_alloc(sizeof(user_data_struct));
	strcpy(user_data->data, "Hello there.!");
	init();
	return user_data;
}

void simple_destructor(godot_object *p_instance, void *p_method_data, void *p_user_data) {
	api->godot_free(p_user_data);
	done();
}

godot_variant simple_get_data(godot_object *p_instance, void *p_method_data,
		void *p_user_data, int p_num_args, godot_variant **p_args) {

	godot_array inp;
	
	inp = api->godot_variant_as_array(p_args[0]);
	int64_t img[100*100];
	int64_t color;
	godot_variant temp;
	int size = api->godot_array_size(&inp);
	char msg[100];
	sprintf(msg, "Array size is %d\n", size);
	for (int i=0; i<size; i++) {
	  temp = api->godot_array_get(&inp, i);
	  img[i] = api->godot_variant_as_int(&temp);
 	}
	user_data_struct* d = (user_data_struct*)p_user_data;
	int* nums = calc(&img); //d->arr
        api->godot_array_new(&(d->gdoarr));
        for (int i=0; i < size; i++) {
          api->godot_variant_new_int(&(d->intarr[i]), nums[i]);
          //api->godot_variant_new_int(&(d->intarr[i]), 155*205*200*2);
	  api->godot_array_push_back(&(d->gdoarr), &(d->intarr[i]));
        }
  	api->godot_variant_new_array(&(d->ret), &(d->gdoarr));
        
	return d->ret;
}


