<template>
    <Input id="search-input" placeholder="Search Products">
        <template #icon>
            <MagnifyingGlassIcon class="icon icon-lg text-black" />
        </template>
    </Input>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import Input from '@/components/reusables/Input.vue';
import {MagnifyingGlassIcon} from '@heroicons/vue/24/solid'

const feature = ref();
</script>
