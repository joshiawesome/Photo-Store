import { IToastProps } from "@/components/reusables/Toast.vue";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useToastStore = defineStore('toast', () => {
    const toastConfig = ref<IToastProps | null>(null)


    function showtoast(config: IToastProps) {
        toastConfig.value = config
    }

    return { toastConfig, showtoast }
})