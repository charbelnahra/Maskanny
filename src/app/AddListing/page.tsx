import PropertyForm from "@/src/features/properties/presentation/components/PropertyForm";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Maskanny | Add A Listing",
};

export default function Page() {
  return <PropertyForm />;
}
