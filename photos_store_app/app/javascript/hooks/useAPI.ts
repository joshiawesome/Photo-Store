
import { ref } from 'vue'

interface IRequestProps {
    url: string
    method: 'GET' | 'POST' | 'PUT' | 'DELETE'
}

function getCSRFToken() {
  return document
    .querySelector<HTMLMetaElement>('meta[name="csrf-token"]')
    ?.content
}

export function useAPI<TResponse, TBody = unknown>() {
    const token = getCSRFToken()
    
    if (!token) {
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
                    'X-CSRF-Token': token,
                    'Accept': 'application/json'
                },
                credentials: 'same-origin',
                body: body ? JSON.stringify(body) : undefined
            })

            if (!res.ok) {
                throw {
                    status: res.status,
                    data: await res.json()
                }
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

