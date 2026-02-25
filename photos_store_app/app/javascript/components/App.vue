<template>
  <div>
    <h1>{{ message }}</h1>
    <button @click="increment">Count: {{ count }}</button>
    <p>Doubles: {{ doubled }}</p>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { useCounterStore } from '../stores/counterStore';
import { storeToRefs } from 'pinia';

const API_TOKEN = import.meta.env.VITE_API_TOKEN
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL

console.log(API_TOKEN, API_BASE_URL)

const message = ref('Hello Pinia + Composition API');
const counter = useCounterStore();
const { count, doubled } = storeToRefs(counter);
const { increment } = counter;

onMounted(async () => {
  try {
    const res = await fetch(`${API_BASE_URL}/collections/all/products?storefront_token=${API_TOKEN}`)
    if (!res.ok) throw new Error('Failed to fetch products')
    const data = await res.json()
    console.log(data)
  } catch (err) {
    console.error(err)
  }
})
</script>
