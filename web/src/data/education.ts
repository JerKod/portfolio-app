export interface Education {
  degree: string;
  institution: string;
  field: string;
  startDate: string; // "AAAA", cohérent avec le reste du site
  endDate: string;
}

export const education: Education[] = [
  {
    degree: "PhD",
    institution: "Université Paris-Est",
    field: "Computational Mechanics",
    startDate: "2015",
    endDate: "2018",
  },
];
