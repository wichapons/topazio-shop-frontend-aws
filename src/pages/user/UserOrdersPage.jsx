import UserOrdersPageComponent from "./components/UserOrdersPageComponent";
import axios from "axios";
import { getApiUrl } from '../../utils/api';

const UserOrdersPage = () => {
  const getOrders = async () => {
    const { data } = await axios.get(getApiUrl("api/orders"));
    return data;
}
  return (
    <UserOrdersPageComponent getOrders={getOrders}/>
  );
};

export default UserOrdersPage;

