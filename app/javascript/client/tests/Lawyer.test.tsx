import renderer from "react-test-renderer";
import { UserAvatar } from "../components/Lawyer/Lawyer";
import { IUser } from "../storage/types";

it("Lawyer::Avatar: show correct data", () => {
  const user: IUser = {
    id: "0",
    confirmed: false,
    email: "gaizkaurdangarin@gmail.com",
    first_name: "Gaizka",
    last_name: "Urdangarin",
    account_type: "user",
  };
  const component = renderer.create(<UserAvatar user={user} size="sm" />);

  const tree = component.toJSON();
  expect(tree).toMatchSnapshot();
});
