<template>
    <IconPopOver ref="searchPopover" :isOpenOnClick="false">
        <template #trigger>
            <Input id="search-input" placeholder="Search Products" v-on:change="onChange">
                <template #icon>
                    <MagnifyingGlassIcon class="icon icon-lg text-black" />
                </template>
            </Input>
        </template>
        <template #content>
            <div class="flex items-center justify-center min-h-20">
                <Loader v-if="isSearching" size="sm" />
                <List v-else-if="suggestions && suggestions.length" :items="suggestions" />
                <div v-else class="text-center text-dark-gray">{{ UI_MESSAGES["NO SEARCH RESULTS"] }}</div>
            </div>
        </template>
    </IconPopOver>
</template>

<script lang="ts" setup>
import { computed, ref, watch } from "vue"
import IconPopOver from "@/components/reusables/IconPopOver.vue"
import Input, { IValue } from "@/components/reusables/Input.vue"
import Loader from "@/components/reusables/Loader.vue"
import List from "@/components/reusables/List.vue"
import { MagnifyingGlassIcon } from "@heroicons/vue/24/solid"
import type { SearchSuggestion } from "@/types/search.types"
import { UI_MESSAGES } from "@/constants/messageConstants"
import { useAPI } from "@/hooks/useAPI"

const searchPopover = ref<InstanceType<typeof IconPopOver> | null>(null)
const suggestions = ref<SearchSuggestion[] | null>(null)
const searchAPI = useAPI<SearchSuggestion[], {}>()

watch(
    () => suggestions.value?.length,
    () => {
        if (!suggestions.value){
            searchPopover.value?.close()
        }
        if (suggestions.value?.length) {
            searchPopover.value?.open()
        }
    },
)

const isSearching = computed(() => searchAPI.loading.value)

const onChange = async (value: IValue) => {
    if (value === "") {
        suggestions.value = null
        return
    }

    try {
        const response = await searchAPI.request({
            url: `/products/search?query=${value}`,
            method: "GET",
        })

        suggestions.value = response
    } catch (error) {
        console.error(error)
    }
}
</script>
