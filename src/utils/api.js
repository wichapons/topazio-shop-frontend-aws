// API configuration utility with hardcoded URLs
const API_BASE_URL = 'https://topazio-shop-backend.onrender.com';

// Create the base API URL for all requests
export const getApiUrl = (endpoint) => {
  // Remove leading slash if present to avoid double slashes
  const cleanEndpoint = endpoint.startsWith('/') ? endpoint.slice(1) : endpoint;
  
  // In development, use the proxy (relative URLs)
  if (import.meta.env.DEV) {
    return `/${cleanEndpoint}`;
  }
  
  // In production, use the full API URL
  return `${API_BASE_URL}/${cleanEndpoint}`;
};

export default {
  getApiUrl
};