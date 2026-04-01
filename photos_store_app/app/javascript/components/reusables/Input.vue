<template>
    <div class="input-wrapper">
        <div class="input-left-wrapper">
            <div class="icon-div flex items-center ml-xs mr-sm">
                <slot name="icon"></slot>
            </div>
            <!-- html attribute binding is done here -->
            <input :id="props.id" :class="`input input-${size}`" :type="inputType" :placeholder="placeholder"
                :value="inputValue" :min="isNumberInput ? min : undefined" :max="isNumberInput ? max : undefined"
                :step="isNumberInput ? step : undefined" :disabled="isDisabled" @input="handleOnChange"
                autocomplete="off" />
        </div>
    </div>
    <span v-if="error" class="text-red text-sm">{{ error }}</span>
</template>

<script lang="ts" setup>
import { computed, InputTypeHTMLAttribute, ref, watch } from 'vue'

export type IValue = string | number | null

interface Props {
    id: string
    passedValue?: IValue
    inputType?: InputTypeHTMLAttribute
    placeholder?: string
    min?: number
    max?: number
    step?: number
    isDisabled?: boolean
    debounceDelay?: number
    onChange?: (value: IValue) => void
    error?: string
    size?: 'sm' | 'md' | 'lg'
}

// the below snippet converts all props to props['propName'] format; reactivity is not lost
// so we can access 'propName' directly in the template
const props = withDefaults(defineProps<Props>(), {
    inputType: "text",
    placeholder: "type here...",
    debounceDelay: 300,
    isDisabled: false,
    size: "md",
    error: ""
})


// local state
const inputValue = ref(props.passedValue)

// computed returns a ref
// the ref is automatically unwrapped when used in templates
const isNumberInput = computed(() => props.inputType === "number")

watch(
    () => props.passedValue,
    (v) => {
        inputValue.value = v
    }
)

let timeout: ReturnType<typeof setTimeout> | null = null

function handleOnChange(event: Event) {
    const target = event.target as HTMLInputElement
    let value: IValue = target.value

    if (isNumberInput.value) {
        value = target.value === "" ? null : Number(target.value)
    }

    function updateValue() {
        // update the local state
        inputValue.value = value
        // notify parent component
        props.onChange?.(value)
    }

    if (props.debounceDelay && props.debounceDelay > 0) {
        if (timeout) clearTimeout(timeout)

        timeout = setTimeout(() => {
            updateValue()
        }, props.debounceDelay)
    } else {
        updateValue()
    }
}


</script>
