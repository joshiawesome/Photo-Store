import { defineStore } from "pinia";
import { ref } from "vue";

export interface IPhotoConfig {
    id: number;
    name: string;
    price: number;
    image_url: string;
}

export const usePhotosStore = defineStore('photos', () => {
    const photos = ref<IPhotoConfig[]>([]);

    return { photos }
})