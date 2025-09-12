import OrdersPageComponent from "./components/OrdersPageComponent";
import axios from "axios";
import { getApiUrl } from '../../utils/api';

const getOrders = async() => {
    const response = await axios.get(getApiUrl("api/orders/admin"));
    return response.data
}

const AdminOrdersPage = () => {
  return <OrdersPageComponent getOrders={getOrders} />
};

export default AdminOrdersPage;

