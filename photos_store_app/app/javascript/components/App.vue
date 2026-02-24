<template>
  <div>
    <h1>{{ message }}</h1>
    <button @click="increment">Count: {{ count }}</button>
  </div>
</template>

<script lang="ts" setup>
import { ref, computed } from 'vue';

const count = ref<number>(0);
const message = ref<string>('Hello Composition API');

function increment(): void {
  count.value++;
}

const doubled = computed(() => count.value * 2);
</script>