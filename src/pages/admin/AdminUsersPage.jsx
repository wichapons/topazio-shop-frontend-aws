import UsersPageComponent from "./components/UsersPageComponent";

import axios from "axios";
import { getApiUrl } from '../../utils/api';

const fetchUsersData = async (abortController) => {
    const response = await axios.get(getApiUrl("api/users"), {
        signal: abortController.signal
    });
    return response.data;
}

const deleteUser = async (userId) => {
  const response = await axios.delete(`/api/users/${userId}`);
  return response.data;
}

const AdminUsersPage = () => {
  return <UsersPageComponent fetchUsersData={fetchUsersData} deleteUser={deleteUser} />;
};

export default AdminUsersPage;

