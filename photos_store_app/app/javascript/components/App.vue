<template>
  <div>
    <h1>{{ message }}</h1>
    <button @click="increment">Count: {{ count }}</button>
    <p>Doubles: {{ doubled }}</p>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { useCounterStore } from '@/stores/counterStore';
import { storeToRefs } from 'pinia';
import { importPhotos } from '@/services/photos/photos_api_service';

const message = ref('Hi!!');
const counter = useCounterStore();
const { count, doubled } = storeToRefs(counter);
const { increment } = counter;

onMounted(() => {
  importPhotos();
})
</script>
