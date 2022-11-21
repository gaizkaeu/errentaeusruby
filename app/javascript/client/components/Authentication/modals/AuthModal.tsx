import { Modal, Text } from "@nextui-org/react";
import { CredentialResponse, GoogleLogin } from "@react-oauth/google";
import { useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import AuthComponent from "../AuthComponent";
import { useGoogleOAuthOneTapCallBackMutation } from "../../../storage/api";

const AuthModal = (props: { method: boolean }) => {
  const nav = useNavigate();
  const loc = useLocation();
  const [open, setOpen] = useState(true);
  const [googleoAuthCallback] = useGoogleOAuthOneTapCallBackMutation();

  const onClose = () => {
    setOpen(false);
    setTimeout(() => {
      nav(loc.state?.background?.pathname ?? "/");
    }, 50);
  };

  const onAuth = () => {
    setOpen(false);
    setTimeout(() => {
      nav(loc.state.nextPage, { replace: true });
    }, 50);
  };

  /*   const googleLogin = useGoogleLogin({
    flow: "auth-code",
    onSuccess: async (codeResponse) => {
      googleoAuthCallback(codeResponse.code).unwrap().then(onAuth);
    },
    onError: (errorResponse) => console.log(errorResponse),
  }); */
  const oneTapSuccess = (res: CredentialResponse) => {
    if (res.credential)
      googleoAuthCallback(res.credential).unwrap().then(onAuth);
  };

  return (
    <div>
      <Modal
        closeButton
        aria-labelledby="modal-title"
        animated={false}
        onClose={onClose}
        preventClose
        open={open}
      >
        <Modal.Header>
          <Text id="modal-title" size={18}>
            <Text b size={18}>
              Con tu cuenta proteges tu información.
            </Text>
          </Text>
        </Modal.Header>
        <Modal.Body>
          <AuthComponent method={props.method} onAuth={onAuth} />
        </Modal.Body>
        <Modal.Footer>
          <GoogleLogin
            useOneTap
            auto_select
            onSuccess={oneTapSuccess}
            onError={() => {
              console.log("Login Failed");
            }}
          />
        </Modal.Footer>
      </Modal>
    </div>
  );
};
export default AuthModal;
