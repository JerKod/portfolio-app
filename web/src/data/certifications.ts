export interface Certification {
  name: string;
  date: string; // format "AAAA-MM", cohérent avec experiences.ts
}

export const certifications: Certification[] = [
  { name: "DevOps Foundation", date: "2021-05" },
  { name: "PRINCE2 Foundation", date: "2021-05" },
  { name: "Scrum Master Accredited Certification", date: "2020-12" },
  { name: "ITIL 4 Foundation", date: "2020-09" },
];

// comparaison avec localeCompare
export const sortedCertifications = [...certifications].sort((a, b) =>
  b.date.localeCompare(a.date)
);
