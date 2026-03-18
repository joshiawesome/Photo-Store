import { ILogin } from "@/types/user.types";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useLoginStore = defineStore('login', () => {
    const login_config = ref<ILogin | null>(null)


    function setLogin(config: ILogin) {
        login_config.value = config
    }

    return { login_config, setLogin }
})