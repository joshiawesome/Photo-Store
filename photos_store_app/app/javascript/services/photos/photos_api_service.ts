import { usePhotosStore } from '@/stores/photosStore';


export async function importPhotos() {
    const token = document.querySelector(
        'meta[name="csrf-token"]'
    ) as HTMLMetaElement | null;

    if (!token) {
        // The CSRF token is used to prevent Cross-Site Request Forgery and is a security measure in Rails
        console.error("CSRF token not found");
        return;
    }

    // Triggger the photos importer to hydrate the local database with photos from the external API
    await fetch("/photos/import", {
        method: "POST",
        headers: {
            "X-CSRF-Token": token.content,
            "Content-Type": "application/json"
        }
    });

    // Fetch the photos from the local database
    const res = await fetch("/photos", {
        headers: { "Accept": "application/json" }
    });
    const photos = await res.json();

    // Hydrate the pinia store with the photos
    usePhotosStore().photos = photos;
}
