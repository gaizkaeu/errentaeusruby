import renderer from "react-test-renderer";
import LawyerAvatar from "../components/Lawyer/Lawyer";
import { IUser } from "../storage/types";

it("Lawyer::Avatar: show correct data", () => {
  const user: IUser = {
    id: "0",
    email: "gaizkaurdangarin@gmail.com",
    name: "Gaizka",
    surname: "Urdangarin",
    account_type: "user",
  };
  const component = renderer.create(<LawyerAvatar lawyer={user} size="sm" />);

  const tree = component.toJSON();
  expect(tree).toMatchSnapshot();
});
