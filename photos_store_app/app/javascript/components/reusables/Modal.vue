<template>
    <Teleport to="body">
        <div v-if="isOpen" class="fixed inset-0 z-50">
            <div class="absolute inset-0 bg-black/50" />
            <div class="relative flex items-center justify-center h-full">
                <div :class="`flex flex-col gap-md bg-white rounded-sm shadow-xl p-md w-modal-${size}`">
                    <!-- Header -->
                    <div class="flex justify-between items-center">
                        <div>
                            <slot name="header-text" />
                        </div>
                        <XMarkIcon class="icon icon-lg" @click="close" />
                    </div>
                    <!-- Content -->
                    <div class="flex-1">
                        <slot name="content" />
                    </div>
                    <!-- Footer -->
                    <div class="flex justify-end gap-sm">
                        <Button :label="cancelText" variant="secondary" @click="close" />
                        <Button :label="submitText" :isDisabled="isSubmitDisabled" @click="onSubmit" />
                    </div>
                </div>
            </div>
        </div>
    </Teleport>
</template>

<script lang="ts" setup>
import { toRefs } from 'vue'
import Button from '@/components/reusables/Button.vue'
import { XMarkIcon } from '@heroicons/vue/24/solid'

interface Props {
    isOpen: boolean
    submitText?: string
    cancelText?: string
    isSubmitDisabled?: boolean
    onSubmit?: () => void
    size?: 'sm' | 'md' | 'lg'

}

const props = withDefaults(defineProps<Props>(), {
    submitText: "Submit",
    cancelText: "Cancel",
    isSubmitDisabled: false,
    onSubmit: () => { },
    size: "sm"
})

// Convert prop to ref for reactivity
const { isOpen, submitText, cancelText, isSubmitDisabled, onSubmit, size } = toRefs(props)


const emit = defineEmits(['update:isOpen'])
const close = () => {
    emit('update:isOpen', false)
}
</script>
