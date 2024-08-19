import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-icons/font/bootstrap-icons.css";
import "./index.css";
import { Provider } from "react-redux";
import store from "./redux/store";
import { asyncWithLDProvider } from 'launchdarkly-react-client-sdk';


(async () => {
  const LDProvider = await asyncWithLDProvider({
    clientSideID: '66614c4f9f013c0fe51a8411',
    context: {
      kind: 'user',
      key: 'example-user-key',
      name: 'Sandy',
    },
  });

  const root = ReactDOM.createRoot(document.getElementById("root")).render(
    <Provider store={store}>
      {/* <React.StrictMode> */}
      <LDProvider>
        <App />
      {/* </React.StrictMode> */}
      </LDProvider>
    </Provider>
  );
})();