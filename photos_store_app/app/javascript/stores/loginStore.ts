import { ILogin } from "@/types/user.types";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useLoginStore = defineStore('login', () => {
    const loginConfig = ref<ILogin | null>(null)


    function setLogin(config: ILogin) {
        loginConfig.value = config
    }

    return { loginConfig, setLogin }
})