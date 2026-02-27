
import { ref } from 'vue'

interface IRequestProps {
    url: string
    method: 'GET' | 'POST' | 'PUT' | 'DELETE'
}

const csrfToken =
    document
        .querySelector<HTMLMetaElement>('meta[name="csrf-token"]')
        ?.content


export function useApi<TResponse, TBody = unknown>() {
    if (!csrfToken) {
        throw new Error('CSRF token not found')
    }

    const response = ref<TResponse | null>(null)
    const error = ref<string | null>(null)
    const loading = ref(false)

    const request = async (
        requestProps
            : IRequestProps & {
                body?: TBody
            }): Promise<TResponse> => {
        const { url, method, body } = requestProps;

        loading.value = true
        error.value = null

        try {
            const res = await fetch(url, {
                method,
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken,
                    'Accept': 'application/json'
                },
                credentials: 'same-origin',
                body: body ? JSON.stringify(body) : undefined
            })

            if (!res.ok) {
                throw new Error(`HTTP ${res.status}`)
            }

            const json: TResponse = await res.json()
            response.value = json
            return json
        } catch (err: any) {
            error.value = err.message
            throw err
        } finally {
            loading.value = false
        }
    }

    return { response, error, loading, request }
}

