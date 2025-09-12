import AdminEditUserPageComponent from "./components/EditUserPageComponent";
import axios from "axios";
import { getApiUrl } from '../../utils/api';

//update user data in database
const updateUserApiRequest = async (userId, name, lastName, email, isAdmin) => {
  const { data } = await axios.put(`/api/users/${userId}`, { name, lastName, email, isAdmin });
    return data;
}

//get user data in database
const fetchUser = async (userId) => {
  const { data } = await axios.get(`/api/users/${userId}`);
  return data;
}


const AdminEditUserPage = () => {
  
  return (
    <AdminEditUserPageComponent updateUserApiRequest={updateUserApiRequest} fetchUser={fetchUser} />
  );
};

export default AdminEditUserPage;



