<template>
    <Button label="Login" @click="openForm" />
    <Modal v-model:is-open="isOpen" submit-text="Login" :isSubmitDisabled="true">
        <template #header-text>
            Welcome Back!
        </template>
        <template #content>
            <!-- Form content -->
        </template>
    </Modal>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import Button from '@/components/reusables/Button.vue'
import Modal from '@/components/reusables/Modal.vue'

const isOpen = ref(false)

const openForm = () => {
    isOpen.value = true
}


</script>
