<template>
  <div>
    <h1>{{ message }}</h1>
    <button @click="increment">Count: {{ count }}</button>
    <p>Doubles: {{ doubled }}</p>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { useCounterStore } from '../stores/counterStore';
import { storeToRefs } from 'pinia';

const message = ref('Hello Pinia + Composition API');
const counter = useCounterStore();
const { count, doubled } = storeToRefs(counter);
const { increment } = counter;
</script>