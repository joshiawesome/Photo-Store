<template>
    <!-- html attribute binding is done here -->
    <input id="photos_app_input_box" :class="`input input-${size}`" :type="inputType" :placeholder="placeholder"
        :value="inputValue" :min="isNumberInput ? min : undefined" :max="isNumberInput ? max : undefined"
        :step="isNumberInput ? step : undefined" :disabled="isDisabled" @input="handleOnChange" />

</template>

<script lang="ts" setup>
import { computed, InputTypeHTMLAttribute, ref, watch } from 'vue'

type IValue = string | number | null

interface Props {
    passedValue: IValue
    inputType?: InputTypeHTMLAttribute
    placeholder?: string
    min?: number
    max?: number
    step?: number
    isDisabled?: boolean
    debounceDelay?: number
    onChange?: (value: IValue) => void
    size?: 'sm' | 'md' | 'lg'
}

// the below snippet converts all props to props['propName'] format; reactivity is not lost
// so we can access 'propName' directly in the template
const props = withDefaults(defineProps<Props>(), {
    inputType: "text",
    placeholder: "type here...",
    debounceDelay: 300,
    isDisabled: false,
    size: "md"
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
