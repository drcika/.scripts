import { render } from '@testing-library/react';
import { ${name_capital} } from './${name}';

describe('${name_capital}', () => {
  it('should render successfully', () => {
    const { baseElement } = render(<${name_capital} />);
    expect(baseElement).toBeTruthy();
  });
});
