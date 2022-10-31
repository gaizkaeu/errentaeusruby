import { Text } from "@nextui-org/react";
import { useTranslation } from "react-i18next";

const Header = (props: { title: string, subtitle: string, gradient: string, subtitle_actions: JSX.Element,children?: JSX.Element }) => {
    const { t, i18n } = useTranslation();
    return (
        <header>
            <section className="py-10 sm:py-16 lg:py-24">
                <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
                    <div className="grid items-center grid-cols-1 gap-12 lg:grid-cols-2">
                        <div>
                            <Text className="text-base font-semibold tracking-wider uppercase">
                                {t("header.elizaasesoresservice")}
                            </Text>
                            <Text
                                className="mt-4 text-5xl font-bold text-black lg:mt-8 sm:text-7xl  xl:text-8xl"
                                css={{
                                    textGradient: props.gradient,
                                }}
                            >
                               {t(props.title)}
                            </Text>
                            <Text className="mt-4 text-base text-black lg:mt-8 sm:text-xl">
                                {t(props.subtitle)}
                            </Text>
                            {props.subtitle_actions}
                        </div>
                        {props.children}
                    </div>
                </div>
            </section>
        </header>
    )
}

export const HeaderMin = (props: {title: string, subtitle?: string, gradient: string, textClass?: string}) => {
    const { t, i18n } = useTranslation();
    return (
        <header>
        <section className="mt-4">
          <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div>
              <Text className="text-base font-semibold tracking-wider">
                {t("header.elizaasesoresservice")}
              </Text>
              <Text
                className={props.textClass ?? "text-5xl font-bold text-black sm:text-7xl xl:text-8xl"}
                css={{
                  textGradient: props.gradient,
                }}
              >
                {t(props.title)}
              </Text>
              <Text h4>
                {t(props.subtitle)} 
              </Text>
            </div>
          </div>
        </section>
      </header>
    )
}

export default Header;