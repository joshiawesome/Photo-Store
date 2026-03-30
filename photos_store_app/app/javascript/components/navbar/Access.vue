<template>
    <Button :label="props.type === 'login' ? 'Login' : 'Sign Up'" @click="openForm" />
    <Modal v-model:is-open="isFormOpen" :onSubmit="onSubmit" :isLoadingOnSubmit="isLoading">
        <template #header-text>
            <div class="text-2xl">{{ props.type === 'login' ? 'Login' : 'Sign Up' }}!</div>
        </template>
        <template #content>
            <div class="relative flex flex-col gap-sm">
                <Input input-type="email" :passed-value="null" placeholder="Email"
                    v-on:change="onChange($event, 'email')" :error="errors?.email?.[0]" />
                <Input input-type="password" :passed-value="null" placeholder="Password"
                    v-on:change="onChange($event, 'password')" :error="errors?.password?.[0]" />
                <div v-if="errors?.base?.[0]" class="text-red text-sm">{{ errors.base[0] }}</div>
            </div>
        </template>
    </Modal>
</template>

<script lang="ts" setup>
import { computed, ref, watch } from 'vue'
import Button from '@/components/reusables/Button.vue'
import Input, { IValue } from '@/components/reusables/Input.vue'
import { UserFormConfig, UserField} from '@/types/user.types'
import Modal from '@/components/reusables/Modal.vue'
import { useAPI } from '@/hooks/useAPI'
import { useLoginStore } from '@/stores/loginStore'
import { useToastStore } from '@/stores/toastStore'

interface Props {
    type: 'login' | 'signup'
}

const props = defineProps<Props>()

const isFormOpen = ref(false)
const formData: UserFormConfig = {
    user: {
        email: '',
        password: ''
    }
}
const errors = ref<Record<string, string[]> | null>(null)
const createUserAPI = useAPI<{message: string, email: string}, UserFormConfig>()

watch(isFormOpen, (newVal) => {
    if (!newVal) {
        formData.user.email = ''
        formData.user.password = ''
        errors.value = null
    }
})
const isLoading = computed(() => createUserAPI.loading.value)

const openForm = () => {
    isFormOpen.value = true
}

const onChange = (value: IValue, type: UserField) => formData.user[type] = value as string


const onSubmit = async () => {
    try {
        const response = await createUserAPI.request({
            url: `/${props.type}`,
            method: "POST",
            body: formData
        })

        useLoginStore().setLogin({
            isLoggedIn: true,
            userName: response.email
        })
        
        useToastStore().showtoast({
            message: response.message,
            type: "success"
        })

        isFormOpen.value = false
    } catch (error: any) {
        errors.value = error.data
    }

}
</script>
