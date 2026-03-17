export interface IUser {
    user:{
        email: string;
        password: string;
    }
}

export type IUserField = 'email' | 'password'