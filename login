"use client";

import React, {useState} from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { useAuth } from "@/app/context/AuthContext";
import Image from "next/image";
import registerImage from "../../../../public/images/register.png"

export default function Register(){

    const router = useRouter();
    const {register} = useAuth();

    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");
    const [password_confirmation, setPasswordConfirmation] = useState("");

    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    const handleRegister = async () => {
        setError("");

        if(!name || !email || !password || !password_confirmation ){
            setError("All fields are required");
            return;
        }

        if(password !== password_confirmation){
            setError("Password do not match");
            return;
        }
        try{
            setLoading(true);
            await register(name, email,password, password_confirmation);
            router.push("/login");
        }catch(err){
            setError("Register failed. Email may already exist.")
        }finally{
            setLoading(false);
        }
    };

    return(
       <div className="max-w-6xl mx-auto min-h-screen flex items-center justify-center bg-gradient-to-br from-gray-50 to-gray-100 px-4">
    
        <div className="w-full max-w-4xl bg-white rounded-2xl shadow-xl flex overflow-hidden">
            {/* Form Section */}
            <div className="w-1/2 p-8 lg:p-10">
                <div className="mb-8">
                    <h1 className="text-3xl font-bold text-gray-900 mb-2">Create account</h1>
                    <p className="text-gray-500 text-sm">Please fill in your details to get started</p>
                </div>
                
                {error && (
                    <div className="mb-6 p-4 bg-red-50 border border-red-100 rounded-lg">
                        <p className="text-sm text-red-600 text-center">{error}</p>
                    </div>
                )}

                <div className="space-y-4">
                    <div>
                        <input 
                            type="text"
                            placeholder="Full name"
                            className="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-700 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition duration-200"
                            value={name}
                            onChange={(e)=> setName(e.target.value)}
                        />
                    </div>
                    
                    <div>
                        <input 
                            type="email"
                            placeholder="Email address"
                            className="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-700 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition duration-200"
                            value={email}
                            onChange={(e)=> setEmail(e.target.value)}
                        />
                    </div>
                    
                    <div>
                        <input 
                            type="password"
                            placeholder="Password"
                            className="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-700 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition duration-200"
                            value={password}
                            onChange={(e)=> setPassword(e.target.value)}
                        />
                    </div>
                    
                    <div>
                        <input 
                            type="password"
                            placeholder="Confirm password"
                            className="w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg text-gray-700 text-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition duration-200"
                            value={password_confirmation}
                            onChange={(e)=> setPasswordConfirmation(e.target.value)}
                        />
                    </div>
                
                    <button 
                        onClick={handleRegister}
                        disabled={loading}
                        className="w-full bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-medium py-3 px-4 rounded-lg text-sm transition duration-200 transform hover:scale-[1.02] active:scale-[0.98] disabled:opacity-70 disabled:cursor-not-allowed disabled:hover:scale-100 shadow-lg shadow-blue-500/25"
                    >
                        {loading ? (
                            <span className="flex items-center justify-center">
                                <svg className="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                                Creating account...
                            </span>
                        ) : "Create account"}
                    </button>
                </div>
            
                <p className="text-sm text-center mt-6 text-gray-600">
                    Already have an account?{" "}
                    <Link href="/login" className="text-blue-600 hover:text-blue-700 font-medium hover:underline transition duration-200">
                        Sign in
                    </Link>
                </p>
            </div>

            {/* Image Section */}
            <div className="w-1/2 bg-gradient-to-br from-blue-600 to-blue-700 hidden md:flex items-center justify-center p-8">
                <div className="relative w-full h-full flex items-center justify-center">
                    <Image 
                        src={registerImage} 
                        alt="Register" 
                        className="w-full h-auto object-contain drop-shadow-2xl"
                        priority
                    />
                </div>
            </div>
        </div>
      </div>
    )
}
