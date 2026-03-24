import { Login } from "@/types/user.types";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useLoginStore = defineStore('login', () => {
    const loginConfig = ref<Login | null>(null)


    function setLogin(config: Login) {
        loginConfig.value = config
    }

    return { loginConfig, setLogin }
})