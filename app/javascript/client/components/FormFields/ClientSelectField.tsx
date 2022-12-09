import { at } from "lodash";
import { Text } from "@nextui-org/react";
import { useField } from "formik";
import { ReactSearchAutocomplete } from "react-search-autocomplete";
import { useLazySearchUserQuery } from "../../storage/api";
import { IUser } from "../../storage/types";
import { UserAvatar } from "../Lawyer/Lawyer";
import { Link } from "react-router-dom";
import { ArrowRightIcon } from "@heroicons/react/24/outline";

export default function ClientSelectField(props: {
  name: string;
  [x: string]: any;
}) {
  const { name } = props;
  const [, meta, helpers] = useField(name);
  const [trigger] = useLazySearchUserQuery();

  const onSelect = (item: IUser) => {
    helpers.setValue(item.id);
  };

  const handleOnSearch = async (string: string) => {
    trigger({ first_name: string })
      .unwrap()
      .then((data) => {
        setItems(data);
      });
  };

  const formatResult = (item: IUser) => {
    return (
      <div key={item.id} className="flex items-center w-full px-5">
        <div className="grow">
          <UserAvatar user={item} size="md" />
        </div>
        <Link to={""}>
          <ArrowRightIcon height="15" />
        </Link>
      </div>
    );
  };

  const search_data: IUser[] = [];
  const [items, setItems] = React.useState(search_data);

  function _renderHelperText() {
    const [touched, error] = at(meta, "touched", "error");
    if (touched && error) {
      return error;
    }
  }

  function _renderColor() {
    if (meta.touched) {
      if (meta.error) {
        return "error";
      }
      return "success";
    }
    return "default";
  }

  return (
    <div className="max-w-lg">
      <ReactSearchAutocomplete
        items={items}
        aria-label="search client"
        onSearch={handleOnSearch}
        resultStringKeyName="first_name"
        onSelect={onSelect}
        showIcon={false}
        showItemsOnFocus
        placeholder="Introduce el cliente"
        fuseOptions={{ keys: ["first_name", "last_name"] }}
        formatResult={formatResult}
      />
      <Text color={_renderColor()}>{_renderHelperText()}</Text>
    </div>
  );
}
