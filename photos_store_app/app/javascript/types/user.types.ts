export interface UserFormConfig {
    user: {
        email: string;
        password: string;
    }
}

export type UserField = 'email' | 'password'


export interface LoginConfig {
    isLoggedIn: boolean
    userName: string
}
