<template>
    <Button label="Login" @click="openForm" />
    <Modal v-model:is-open="isOpen" submit-text="Login" :isSubmitDisabled="true">
        <template #header-text>
            <div class="text-2xl">Welcome Back!</div>
        </template>
        <template #content>
            <Input :passed-value="null" />
        </template>
    </Modal>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import Button from '@/components/reusables/Button.vue'
import Input from '@/components/reusables/Input.vue'
import Modal from '@/components/reusables/Modal.vue'


const isOpen = ref(false)

const openForm = () => {
    isOpen.value = true
}


</script>
