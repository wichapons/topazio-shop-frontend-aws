import { Helmet, HelmetProvider } from "react-helmet-async";

 const MetaComponent = ({ title = "TrueIDC", description="MERN stack e-commerce website" }) => {
    return (
       <HelmetProvider>
           <Helmet>
              <title>{title}</title> 
              <meta name="description" content={description} />
           </Helmet>
       </HelmetProvider> 
    )
 }

 export default MetaComponent
