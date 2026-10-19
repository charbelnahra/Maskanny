import { ListingsBrowser } from "@/src/features/properties/presentation/components/ListingsBrowser";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Maskanny | Browse Student Housing",
};

export default async function PropertiesPage({
  searchParams,
}: {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
}) {
  const filters = await searchParams;
  return <ListingsBrowser searchParams={filters} />;
}
