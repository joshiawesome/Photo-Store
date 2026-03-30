import { LoginConfig } from "@/types/user.types";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useLoginStore = defineStore('login', () => {
    const loginConfig = ref<LoginConfig | null>(null)


    function setLogin(config: LoginConfig) {
        loginConfig.value = config
    }

    return { loginConfig, setLogin }
})