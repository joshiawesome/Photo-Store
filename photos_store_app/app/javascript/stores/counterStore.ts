import { defineStore } from 'pinia';
import { ref, computed } from 'vue';

export const useCounterStore = defineStore('counter', () => {
    // state
    const count = ref<number>(0)

    // actions
    function increment() {
        count.value++
    }

    // getters
    const doubled = computed(() => count.value * 2)

    return { count, increment, doubled }
})