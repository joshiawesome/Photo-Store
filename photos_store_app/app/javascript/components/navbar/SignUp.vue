<template>
    <Button label="Sign Up" @click="openForm" />
    <Modal v-model:is-open="isOpen" :isSubmitDisabled="true">
        <template #header-text>
            <div class="text-2xl">Sign Up!</div>
        </template>
        <template #content>
            <div class="flex flex-col gap-sm">
                <Input input-type="email" :passed-value="null" placeholder="Email" />
                <Input input-type="password" :passed-value="null" placeholder="Password" />
            </div>
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
