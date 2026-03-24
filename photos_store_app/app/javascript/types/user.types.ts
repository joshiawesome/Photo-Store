export interface User {
    user:{
        email: string;
        password: string;
    }
}

export type UserField= 'email' | 'password'


export interface Login{
    isLoggedIn: boolean
    userName: string
}
