import HomePageComponent from "./components/HomePageComponent";
import { useSelector } from "react-redux";
import axios from "axios";
import { getApiUrl } from '../utils/api';

//getBestsellers products
const getBestsellers = async () => {
  const { data } = await axios.get(getApiUrl("api/products/bestsellers"));
  return data;
}

const HomePage = () => {
  //get categories from redux state
  const { categories } = useSelector((state) => state.getCategories);


  return (
    <HomePageComponent categories = {categories} getBestsellers={getBestsellers} />
  )
};

export default HomePage;
