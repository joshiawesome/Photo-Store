import { IToastProps } from "@/components/reusables/Toast.vue";
import { defineStore } from "pinia";
import { ref } from "vue";



export const useToastStore = defineStore('toast', () => {
    const toast_config = ref<IToastProps | null>(null)


    function showtoast(config: IToastProps) {
        toast_config.value = config
    }

    return { toast_config, showtoast }
})