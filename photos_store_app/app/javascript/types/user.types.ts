export interface IUser {
    user:{
        email: string;
        password: string;
    }
}

export type IUserField = 'email' | 'password'


export interface ILogin{
    isLoggedIn: boolean
    userName: string
}
