export const getUserNameFromEmail = (email: string): string => {
    return email.split('@')[0]
}