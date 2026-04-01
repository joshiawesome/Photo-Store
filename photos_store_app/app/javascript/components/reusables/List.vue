<template>
  <div class="w-full whitespace-nowrap">
    <ul>
      <li class="cursor-pointer hover:bg-light-gray p-sm" v-for="item in items" :key="item.id" @click="onClick?.(item.id)">
        {{ item.name }}
      </li>
    </ul>
  </div>
</template>

<script lang="ts" setup>

interface ListItem {
  id: string
  name: string
}

const props = defineProps<{
  items: ListItem[]
  onClick?: (id: string) => void
}>()

</script>
